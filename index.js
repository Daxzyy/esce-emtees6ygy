const express = require('express');
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const fsp = require('fs').promises; 

const app = express();
const port = 5001; 

// --- KONSTANTA GLOBAL ---
const TOTAL_VPS_STORAGE_GB = 1; // Batas Total Kuota 1 GB
const MAX_FILE_SIZE_BYTES = 50 * 1024 * 1024; // Batas File Tunggal 50 MB
const EXPIRY_TIME_MS = 30 * 60 * 1000; // 30 menit
const CLEANUP_INTERVAL_MS = 5 * 60 * 1000; // Periksa file kadaluarsa setiap 5 menit
// -----------------------------

app.use(express.urlencoded({ extended: true }));

// --- Fungsi Helper ---

function formatBytes(bytes, decimals = 2) {
    if (bytes === 0) return `0 Bytes`;
    const k = 1024;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB']; 
    const i = Math.floor(Math.log(bytes) / Math.log(k)); 
    return parseFloat((bytes / Math.pow(k, i)).toFixed(decimals)) + ' ' + sizes[i];
}

async function getUploadsSize(dir) {
    let size = 0;
    if (!fs.existsSync(dir)) {
        return 0;
    }
    const files = await fsp.readdir(dir);
    for (const file of files) {
        if (file.startsWith('.')) continue;
        const filePath = path.join(dir, file);
        try {
            const stat = await fsp.stat(filePath);
            if (stat.isFile()) {
                size += stat.size;
            } else if (stat.isDirectory()) {
                size += await getUploadsSize(filePath);
            }
        } catch (e) {
            console.error(`Error statting file ${filePath}:`, e);
        }
    }
    return size;
}

function bytesToGB(bytes) {
    return bytes / (1024 * 1024 * 1024);
}

const generateRandomId = () => {
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    let result = '';
    const length = 4;
    
    let hasLetter = false;
    let hasNumber = false;

    for (let i = 0; i < length; i++) {
        const char = characters.charAt(Math.floor(Math.random() * characters.length));
        result += char;

        if (char >= '0' && char <= '9') {
            hasNumber = true;
        } else {
            hasLetter = true;
        }
    }
    
    if (!hasNumber) {
        const numberChars = '0123456789';
        const randomIndex = Math.floor(Math.random() * length);
        result = result.substring(0, randomIndex) + numberChars.charAt(Math.floor(Math.random() * numberChars.length)) + result.substring(randomIndex + 1);
    } 
    else if (!hasLetter) {
        const letterChars = 'abcdefghijklmnopqrstuvwxyz';
        const randomIndex = Math.floor(Math.random() * length);
        result = result.substring(0, randomIndex) + letterChars.charAt(Math.floor(Math.random() * letterChars.length)) + result.substring(randomIndex + 1);
    }
    
    return result;
};

const UPLOAD_ROOT = path.join(__dirname, 'public'); 
const UPLOAD_SUBDIR = 'uploads'; 
const UPLOAD_DIR = path.join(UPLOAD_ROOT, UPLOAD_SUBDIR); 
const DOMAIN = 'https://ikram.my.id/';

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

app.use((req, res, next) => {
    if (req.path.includes('/upload') || req.path.includes('/list') || req.path.includes('/status-disk') || req.path === '/') {
        return next();
    }

    const requestedPath = path.join(UPLOAD_ROOT, req.path);
    
    if (fs.existsSync(requestedPath) && fs.statSync(requestedPath).isFile()) {
        return next();
    }
    
    const uploadPath = path.join('/', UPLOAD_SUBDIR, req.path);
    req.url = uploadPath;
    
    next();
});

// === MIDDLEWARE UNTUK HANDLE FILE DOWNLOADS (SEBELUM STATIC) ===
app.use((req, res, next) => {
    const filePath = path.join(UPLOAD_DIR, path.basename(req.path));
    
    if (fs.existsSync(filePath) && fs.statSync(filePath).isFile()) {
        const forceDownloadExtensions = ['.html', '.htm', '.svg', '.xml', '.csv'];
        const fileExt = path.extname(filePath).toLowerCase();
        
        if (forceDownloadExtensions.includes(fileExt)) {
            res.setHeader('Content-Disposition', `attachment; filename="${path.basename(filePath)}"`);
            return res.sendFile(filePath);
        }
    }
    
    next();
});

// === MIDDLEWARE STATIS ===
app.use(express.static(UPLOAD_ROOT)); 

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        if (!fs.existsSync(UPLOAD_DIR)) {
            fs.mkdirSync(UPLOAD_DIR, { recursive: true });
        }
        cb(null, UPLOAD_DIR); 
    },
    filename: (req, file, cb) => {
        const randomId = generateRandomId();
        const fileExtension = path.extname(file.originalname);
        cb(null, randomId + fileExtension);
    }
});

const fileFilter = (req, file, cb) => {
    const blockedExtensions = ['.php', '.phtml', '.php3', '.php4', '.php5', '.asp', '.aspx', '.exe', '.bat', '.sh', '.vbs', '.scr', '.com', '.pif', '.msi'];
    
    if (file.size > MAX_FILE_SIZE_BYTES) {
        return cb(new Error('Ukuran file melebihi batas 5MB.'), false);
    }
    
    const fileExtension = path.extname(file.originalname).toLowerCase();
    if (blockedExtensions.includes(fileExtension)) {
        return cb(new Error(`Ekstensi file (${fileExtension}) dilarang karena alasan keamanan.`), false);
    }
    
    cb(null, true);
};

const upload = multer({ 
    storage: storage,
    limits: { fileSize: MAX_FILE_SIZE_BYTES },
    fileFilter: fileFilter
});

// === MIDDLEWARE PRE-UPLOAD QUOTA CHECK ===
const preUploadQuotaCheck = async (req, res, next) => {
    const totalGB = TOTAL_VPS_STORAGE_GB; 
    
    const incomingFileSizeStr = req.headers['content-length'];
    const incomingFileSize = parseInt(incomingFileSizeStr, 10) || 0;

    if (incomingFileSize === 0 || incomingFileSize > (MAX_FILE_SIZE_BYTES + 1024)) {
        return next();
    }
    
    try {
        const usedBytes = await getUploadsSize(UPLOAD_DIR);
        const projectedUsedGB = bytesToGB(usedBytes + incomingFileSize); 

        if (projectedUsedGB > totalGB) {
            return res.status(403).send({ 
                success: false, 
                message: "Penyimpanan nya dah full cik😹🤫"
            });
        }
    } catch (error) {
        console.error('Error saat pre-check kuota disk:', error);
    }
    
    next();
};

app.get('/status-disk/', async (req, res) => {
    try {
        const usedBytes = await getUploadsSize(UPLOAD_DIR);
        const usedFormatted = formatBytes(usedBytes); 
        const totalGB = TOTAL_VPS_STORAGE_GB; 
        const usedGB = bytesToGB(usedBytes);
        const usedPercentage = (usedGB / totalGB) * 100;
        const clampedPercentage = Math.min(100, usedPercentage); 
        const totalFormatted = totalGB.toFixed(2) + ' GB'; 

        res.status(200).send({
            success: true,
            usedPercentage: clampedPercentage, 
            used: usedFormatted, 
            total: totalFormatted 
        });
    } catch (error) {
        console.error('Error fetching uploads disk usage:', error);
        res.status(500).send({ 
            success: false, 
            message: 'Gagal menghitung ukuran folder uploads.',
            usedPercentage: 0,
            used: '0 Bytes',
            total: `${TOTAL_VPS_STORAGE_GB.toFixed(2)} GB`
        });
    }
});

// === Rute Upload ===
app.post('/upload/', preUploadQuotaCheck, upload.single('file'), async (req, res) => {
    if (!req.file) {
        return res.status(400).send({ success: false, message: 'Tidak ada file yang diupload.' });
    }
    
    const expiryMessage = 'File akan kadaluarsa dalam 30 Menit.';
    const filePath = path.join(UPLOAD_DIR, req.file.filename);
    
    // PRIMARY DELETION: Jadwalkan penghapusan cepat (30 menit)
    setTimeout(() => {
        fs.unlink(filePath, (err) => {
            if (err) {
                // Jangan khawatir, failsafe cleanup job akan menghapusnya nanti
                console.error(`[TIMEOUT FAIL] Gagal menghapus file kadaluarsa ${req.file.filename}:`, err);
            } else {
                console.log(`[TIMEOUT DELETED] File kadaluarsa berhasil dihapus: ${req.file.filename}`);
            }
        });
    }, EXPIRY_TIME_MS);
    
    const fileUrl = DOMAIN + req.file.filename; 

    res.status(200).send({
        success: true,
        message: 'File berhasil diupload. ' + expiryMessage, 
        filename: req.file.filename,
        url: fileUrl 
    });
});
// ===========================================

app.get('/list', (req, res) => {
    try {
        const files = fs.readdirSync(UPLOAD_DIR);
        const uploadedFiles = files.filter(name => !name.startsWith('.'));
        const fileListWithUrl = uploadedFiles.map(name => ({
            filename: name,
            url: DOMAIN + name 
        }));

        res.status(200).send({
            success: true,
            total: fileListWithUrl.length,
            files: fileListWithUrl
        });

    } catch (error) {
        console.error('Error reading file directory:', error);
        res.status(500).send({ success: false, message: 'Gagal membaca direktori upload.' });
    }
});

app.get('/upload/', (req, res) => {
    res.status(200).send('Ini adalah endpoint POST untuk upload file. Akses halaman utama untuk form.');
});

app.use((err, req, res, next) => {
    if (err instanceof multer.MulterError) {
        return res.status(400).send({ success: false, message: `Upload Error: ${err.message}` });
    } else if (err) {
        return res.status(400).send({ success: false, message: `Validasi Error: ${err.message}` });
    }
    next();
});


// === ROBUST FILE CLEANUP JOB (FAILSAFE AGAINST RESTART) ===
async function cleanUpExpiredFiles() {
    console.log('[CLEANUP] Starting failsafe cleanup job...');
    const now = Date.now();
    
    try {
        const files = await fsp.readdir(UPLOAD_DIR);
        for (const file of files) {
            if (file.startsWith('.')) continue; // Abaikan file tersembunyi
            const filePath = path.join(UPLOAD_DIR, file);
            
            try {
                const stat = await fsp.stat(filePath);
                // mtimeMs adalah waktu modifikasi file
                const fileAge = now - stat.mtimeMs; 
                
                if (stat.isFile() && fileAge > EXPIRY_TIME_MS) {
                    await fsp.unlink(filePath);
                    console.log(`[CLEANUP DELETED] File expired dan dihapus oleh failsafe: ${file}`);
                }
            } catch (err) {
                console.error(`[CLEANUP ERROR] Gagal memeriksa atau menghapus file ${file}:`, err);
            }
        }
    } catch (err) {
        console.error('[CLEANUP FATAL] Gagal membaca direktori upload:', err);
    }
    console.log('[CLEANUP] Cleanup job finished.');
}

// 1. Jalankan cleanup saat server start
cleanUpExpiredFiles(); 
// 2. Jalankan cleanup secara berkala (setiap 5 menit)
setInterval(cleanUpExpiredFiles, CLEANUP_INTERVAL_MS);
// ========================================================


app.listen(port, () => {
    console.log(`CDN Upload API berjalan di http://localhost:${port}`);
});