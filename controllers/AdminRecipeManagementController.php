<?php
namespace App\Controllers;

use App\Core\AdminController;
use App\Models\CategoryModel;
use App\Models\IngredientModel;
use App\Models\RecipeModel;

class AdminRecipeManagementController extends AdminController {

    public function recipes() {
        $rm = new RecipeModel($this->getDatabaseConnection());
        $items = $rm->getAllSorted();
        
        $this->set('recipes', $items);
        
    }

    public function getAdd() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $im = new IngredientModel($this->getDatabaseConnection());
        $categories = $cm->getAll();
        $ingredients = $im->getAll();
        $this->set('categories', $categories);
        $this->set('ingredients', $ingredients);
    }

    private function doUpload($fieldName, $filename) {
        $path = new \Upload\Storage\FileSystem(\Configuration::UPLOAD_DIR);
        $file = new \Upload\File($fieldName, $path);
        $file->setName($filename);
        $file->addValidations([
            new \Upload\Validation\Mimetype('image/jpeg'),
            new \Upload\Validation\Size('3M')
        ]);

        try {
            $file->upload();
            return true;
        } catch (\Exception $e) {
            $this->set('message', 'Došlo je do greške: ' . implode(', ', $file->getErrors()));
            return false;
        }
    }

    public function getEdit($id) {
        $rm = new RecipeModel($this->getDatabaseConnection());
        $cm = new CategoryModel($this->getDatabaseConnection());
        $im = new IngredientModel($this->getDatabaseConnection());
        $categories = $cm->getAll();
        $ingredients = $im->getAll();
        $this->set('categories', $categories);
        $this->set('ingredients', $ingredients);

        $recipe = $rm->getById($id);

        if (!$recipe) {
            \ob_clean();
            header('Location: ' . BASE . 'admin/recipes');
            exit;
        }

        $this->set('recipe', $recipe);
    }

    public function postAdd() {
        $title       = filter_input(INPUT_POST, 'title', FILTER_SANITIZE_STRING);
        $description = filter_input(INPUT_POST, 'description', FILTER_SANITIZE_STRING);
        $amount      = filter_input_array(INPUT_POST, 'amount', FILTER_SANITIZE_STRING);
        $unit_measure= filter_input_array(INPUT_POST, 'unit_measure', FILTER_SANITIZE_STRING);
        $name          = filter_input_array(INPUT_POST, 'name', FILTER_SANITIZE_STRING);
        $categoryId  = filter_input(INPUT_POST, 'category_id', FILTER_SANITIZE_NUMBER_INT);
       

        $rm = new RecipeModel($this->getDatabaseConnection());

        
        $recipeId = $rm->add([
            'title' => $title,
            'description' => $description,
            'image_path' => rand(1000, 9999),
            'admin_id' => $this->getSession()->get('adminId')
        ]);

        

        if (!$recipeId) {
            $this->set('message', 'Došlo je do greške prilikom dodavanja novog recepta.');
            return;
        }

        if (!$this->doUpload('image', $recipeId)) { 
            return;
        }

        \ob_clean();
        header('Location: ' . BASE . 'recipe/' . $recipeId);
        exit;
    }

    

    
}
