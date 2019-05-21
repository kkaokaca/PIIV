<?php
namespace App\Controllers;

use App\Models\CategoryModel;
use App\Core\ApiController;
use App\Models\AuctionModel;

class MainApiController extends ApiController {
    public function categories() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $items = $cm->getAll();
        $this->set('categories', $items);
        sleep(1);
    }

    public function auctions($categoryId) {
        $am = new AuctionModel($this->getDatabaseConnection());
        $items = $am->getAllByCategoryId($categoryId);
        $this->set('auctions', $items);
        sleep(1);
    }
}
