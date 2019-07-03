<?php
namespace App\Controllers;

use App\Models\CategoryModel;
use App\Core\ApiController;
use App\Models\RecipeModel;

class MainApiController extends ApiController {
    public function categories() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $items = $cm->getAll();
        $this->set('categories', $items);
        sleep(1);
    }

    public function recipes($categoryId) {
        $am = new RecipeModel($this->getDatabaseConnection());
        $items = $am->getAllByCategoryId($categoryId);
        $this->set('recipes', $items);
        sleep(1);
    }
}
