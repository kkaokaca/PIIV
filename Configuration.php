<?php
    final class Configuration {
        const BASE = 'http://localhost/nedelja01/';

        const DATABASE_HOST = 'localhost';
        const DATABASE_USER = 'student';
        const DATABASE_PASS = 'student';
        const DATABASE_NAME = 'auction_project';

        const SESSION_STORAGE_CLASS = '\\App\\Core\\Session\\FileSessionStorage';
        const SESSION_STORAGE_ARGUMENTS = [ './session/' ]; # !!!

        const FINGERPRINT_PROVIDER_CLASS = '\\App\\Core\\Fingerprint\\BasicFingerprintProvider';

        const UPLOAD_DIR = 'assets/uploads/';
    }
