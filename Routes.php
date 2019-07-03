<?php
    use App\Core\Route;

    return [
        Route::get('#^admin/login/?$#',                     'Main',         'loginGet'),
        Route::post('#^admin/login/?$#',                    'Main',         'loginPost'),
        Route::post('#^admin/logout/?$#',                   'Main',         'logoutGet'),
    
        Route::get('|^admin/dashboard/?$|',                 'adminDashboard', 'index'),
    
        Route::get('#^categories/?$#',                     'Main',        'home'),
        Route::get('#^recipes/?$#',                        'Main',        'getRecepies'),
        Route::get('|^category/([0-9]+)/?$|',              'Main',        'showCategoryRecipes'),
        Route::get('|^recipe/([0-9]+)/?$|',                'Main',        'showRecipe'),
        Route::get('|^ingredient/([0-9]+)/?$|',            'Main',        'showIngredientRecipes'),
        Route::post('|^search/?$|',                        'Recipe',      'postSearch'),
    

        Route::get('#^admin/categories/?$#',                'AdminCategoryManagement', 'categories'),
        Route::get('#^admin/categories/add/?$#',            'AdminCategoryManagement', 'getAdd'),
        Route::post('#^admin/categories/add/?$#',           'AdminCategoryManagement', 'postAdd'),
        Route::get('#^admin/categories/edit/([0-9]+)/?$#',  'AdminCategoryManagement', 'getEdit'),
        Route::post('#^admin/categories/edit/([0-9]+)/?$#', 'AdminCategoryManagement', 'postEdit'),

        Route::get('#^admin/recipes/?$#',                  'AdminRecipeManagement', 'recipes'),
        Route::get('#^admin/recipes/add/?$#',              'AdminRecipeManagement', 'getAdd'),
        Route::post('#^admin/recipes/add/?$#',             'AdminRecipeManagement', 'postAdd'),
        Route::get('#^admin/recipes/edit/([0-9]+)/?$#',    'AdminRecipeManagement', 'getEdit'),
        Route::post('#^admin/recipes/edit/([0-9]+)/?$#',   'AdminRecipeManagement', 'postEdit'),


        # Fallback
        Route::get('#^.*$#', 'Main', 'home')
    ];
