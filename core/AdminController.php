<?php
    namespace App\Core;

    class AdminController extends Controller {
        public function __pre() {
            if (!$this->getSession()->get('adminId', null)) {
                ob_clean();
                header('Location: ' . BASE . 'admin/login', true, 307);
                exit;
            }
        }
    }
