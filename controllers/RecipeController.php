<?php
namespace App\Controllers;

use App\Models\RecipeModel;
use App\Core\Controller;

class RecipeController extends Controller {
    public function show($recipeId) {
        $rm = new RecipeModel($this->getDatabaseConnection());
        $recipe = $rm->getById($recipeId);

        // if ( !$rm->isActive($recipe) ) {
        //     ob_clean();
        //     header('Location: ' . BASE);
        //     exit;
        // }

        // $om = new OfferModel($this->getDatabaseConnection());
        // $offers = $om->getAllByrecipeId($recipeId);
        
        // $price = $recipe->starting_price;

        // if (count($offers) > 0) {
        //     $lastOffer = $offers[ count($offers) - 1 ];
        //     $price = $lastOffer->price;
        // }

        // $this->set('recipe', $recipe);
        // $this->set('lastPrice', $price);
    }

    public function postSearch() {
        $keyword = filter_input(INPUT_POST, 'search', FILTER_SANITIZE_STRING);

        $am = new RecipeModel($this->getDatabaseConnection());

        $recipes = $am->getAllActiveBySearch($keyword);

        $this->set('recipes', $recipes);
    }
}
