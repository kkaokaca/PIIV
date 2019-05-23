<?php
    use App\Core\Route;

    return [
        Route::get('#^user/register/?$#',                  'Main',         'getRegister'),
        Route::post('#^user/register/?$#',                 'Main',         'postRegister'),
        Route::get('#^user/login/?$#',                     'Main',         'loginGet'),
        Route::post('#^user/login/?$#',                    'Main',         'loginPost'),
    
        Route::get('|^user/dashboard/?$|',                 'UserDashboard', 'index'),
    
        Route::get('#^categories/?$#',                     'Main',         'home'),
        Route::get('|^category/([0-9]+)/?$|',              'Main',         'showCategoryAuctions'),
        Route::get('#^auction/([0-9]+)/?$#',               'Auction',      'show'),
        Route::post('|^search/?$|',                        'Auction',      'postSearch'),
    
        Route::get('#^api/categories/?$#',                 'MainApi',      'categories'),
        Route::get('#^api/auctions/([0-9]+)/?$#',          'MainApi',      'auctions'),
        Route::get('#^api/bookmarks/?$#',                  'BookmarkApi',  'getBookmarks'),
        Route::get('#^api/bookmarks/add/([0-9]+)/?$#',     'BookmarkApi',  'addBookmark'),
        Route::get('#^api/bookmarks/clear/?$#',            'BookmarkApi',  'clear'),
    
        Route::get('#^user/categories/?$#',                'UserCategoryManagement', 'categories'),
        Route::get('#^user/categories/add/?$#',            'UserCategoryManagement', 'getAdd'),
        Route::post('#^user/categories/add/?$#',           'UserCategoryManagement', 'postAdd'),
        Route::get('#^user/categories/edit/([0-9]+)/?$#',  'UserCategoryManagement', 'getEdit'),
        Route::post('#^user/categories/edit/([0-9]+)/?$#', 'UserCategoryManagement', 'postEdit'),

        # Fallback
        Route::get('#^.*$#', 'Main', 'home')
    ];
