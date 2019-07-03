<?php
namespace App\Controllers;

use App\Core\AdminController;
use App\Models\IngredientModel;

class AdminIngredientManagementController extends AdminController {
    public function ingredients() {
        $im = new IngredientModel($this->getDatabaseConnection());
        $items = $im->getAll();
        
        $this->set('ingredients', $items);
        
    }

}
