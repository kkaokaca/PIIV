<?php
namespace App\Controllers;

use App\Models\CategoryModel;
use App\Core\Controller;
use App\Models\RecipeModel;
use App\Models\AdminModel;
use App\Models\RecipeIngredientModel;
use App\Validators\StringValidator;

class MainController extends Controller {
    public function home() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $categories = $cm->getAll();
        
        $this->set('categories', $categories);
    }

    public function getRecepies() {
        $rm = new RecipeModel($this->getDatabaseConnection());
        $recepies = $rm->getAll();
        
        $this->set('recepies', $recepies);
    }

    public function showIngredientRecipes($ingredientId) {
        $rim = new RecipeIngredientModel($this->getDatabaseConnection());
        $recipes = $rim->getRecipeByIngredientId($ingredientId);
        
        $this->set('recipes', $recipes);

    }

    public function categoriesSortedById() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $categories = $cm->getAll();

        usort($categories, function($a, $b) {
            return $b->name <=> $a->name;
        });

        $this->set('categories', $categories);
    }

    public function showCategoryRecipes($categoryId) {
        // $rm = new RecipeModel($this->getDatabaseConnection());
        // $recipes = $rm->getAllByCategoryId($categoryId);
        // $this->set('recipes', $recipes);

        // $cm = new CategoryModel($this->getDatabaseConnection());
        // $category = $cm->getById($categoryId);
        // $this->set('category', $category);
        $categoryModel = new \App\Models\CategoryModel($this->getDatabaseConnection());
        $category = $categoryModel->getById($categoryId);
        
        //ako dati id ne postoji u bazi pa prema tome ni podaci o toj kategoriji:
        if(!$category) {
            header('Location: /nedelja01'); //za sada samo redirekcija na homepage
            exit;
        }

        $this->set('category', $category);


        $recipesInCategory = [];
        $recipeIds = [];
        $recipesInCategoryKeys = $categoryModel->getRecipesByCategoryId($category->category_id);
        foreach($recipesInCategoryKeys as $recipesInCategoryKey) {
            $recipeIds[] = $recipesInCategoryKey->recipe_id;
        }
       
        $recipeModel = new \App\Models\RecipeModel($this->getDatabaseConnection());
        
        $visibleRecipes = $recipeModel->getAll(); 
        $visibleRecipesInCategory = [];
        foreach($recipeIds as $recipeId) {
            $recipesInCategory[] = $recipeModel->getById($recipeId);  
        }
        foreach($recipesInCategory as $recipeInCategory) {
            if(\in_array($recipeInCategory, $visibleRecipes)) {
                $visibleRecipesInCategory[] = $recipeInCategory;
            }
        }
        

        $this->set('recipesInCategory', $visibleRecipesInCategory);
    }

    public function loginGet() {
        $this->getSession()->clear();
    }

    public function loginPost() {
        $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
        $password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

        $am = new AdminModel($this->getDatabaseConnection());

        $admin = $am->getByFieldName('username', $username);

        if (!$admin) {
            sleep(1);
            $this->set('message', 'Losi podaci!');
            return;
        }

        if (!password_verify($password,$admin->password_hash)) {
            sleep(1);
            $this->set('message', 'Losi podaci!');
            return;
        }

        $this->getSession()->put('adminId', $admin->admin_id);

        \ob_clean();
        header('Location: ' . BASE . 'admin/dashboard/');
        exit;
    }

   

    public function showRecipe($id){
        $rm = new RecipeModel($this->getDatabaseConnection());
        $item = $rm->getById($id);
        $ingredients = $rm->getRecipeIngredientDetailById($id);
        
        $this->set('recipe', $item);
        $this->set('ingredients', $ingredients);
    }


    public function logoutGet(){
        $this->getSession()->remove('admin_id');
        $this->getSession()->save();
        $this->redirect(\Configuration::BASE);
    }

}
