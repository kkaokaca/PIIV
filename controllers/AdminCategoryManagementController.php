<?php
namespace App\Controllers;

use App\Core\AdminController;
use App\Models\CategoryModel;

class AdminCategoryManagementController extends AdminController {
    public function categories() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $items = $cm->getAllSorted();
        
        $this->set('categories', $items);
        
    }

    public function getAdd() {
        
    }

    public function postAdd() {
        $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
        $adminId = $this->getSession()->get('adminId');
        $cm = new CategoryModel($this->getDatabaseConnection());

        $categoryId = $cm->add([
            'name' => $name,
            'admin_id' => $adminId

        ]);
        
        
        if (!$categoryId) {
            $this->set('message', 'Došlo je do greške prilikom dodavanja nove kategorije.');
            return;
        }

        \ob_clean();
        header('Location: ' . BASE . 'admin/categories');
        exit;
    }

    public function getEdit($id) {
        $cm = new CategoryModel($this->getDatabaseConnection());

        $category = $cm->getById($id);

        if (!$category) {
            \ob_clean();
            header('Location: ' . BASE . 'admin/categories');
            exit;
        }

        $this->set('category', $category);
    }

    public function postEdit($id) {
        $this->getEdit($id);

        $name = filter_input(INPUT_POST, 'name', FILTER_SANITIZE_STRING);

        $cm = new CategoryModel($this->getDatabaseConnection());

        $res = $cm->editById($id, [
            'name' => $name
        ]);
        
        if (!$res) {
            $this->set('message', 'Došlo je do greške prilikom izmene podataka ove kategorije.');
            return;
        }

        \ob_clean();
        header('Location: ' . BASE . 'admin/categories');
        exit;
    }
}
