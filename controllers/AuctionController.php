<?php
namespace App\Controllers;

use App\Models\AuctionModel;
use App\Core\Controller;
use App\Models\OfferModel;

class AuctionController extends Controller {
    public function show($auctionId) {
        $am = new AuctionModel($this->getDatabaseConnection());
        $auction = $am->getById($auctionId);

        if ( !$am->isActive($auction) ) {
            ob_clean();
            header('Location: ' . BASE);
            exit;
        }

        $om = new OfferModel($this->getDatabaseConnection());
        $offers = $om->getAllByAuctionId($auctionId);
        
        $price = $auction->starting_price;

        if (count($offers) > 0) {
            $lastOffer = $offers[ count($offers) - 1 ];
            $price = $lastOffer->price;
        }

        $this->set('auction', $auction);
        $this->set('lastPrice', $price);
    }

    public function postSearch() {
        $keyword = filter_input(INPUT_POST, 'search', FILTER_SANITIZE_STRING);

        $am = new AuctionModel($this->getDatabaseConnection());

        $auctions = $am->getAllActiveBySearch($keyword);

        $this->set('auctions', $auctions);
    }
}
