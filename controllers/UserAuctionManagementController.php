<?php
namespace App\Controllers;

use App\Core\UserController;
use App\Models\CategoryModel;
use App\Models\AuctionModel;

class UserAuctionManagementController extends UserController {
    public function getAdd() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $items = $cm->getAll();
        $this->set('categories', $items);
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

    public function postAdd() {
        $title = filter_input(INPUT_POST, 'title', FILTER_SANITIZE_STRING);
        $description = filter_input(INPUT_POST, 'description', FILTER_SANITIZE_STRING);
        $startsAt = filter_input(INPUT_POST, 'starts_at', FILTER_SANITIZE_STRING);
        $endsAt = filter_input(INPUT_POST, 'ends_at', FILTER_SANITIZE_STRING);
        $startingPrice = filter_input(INPUT_POST, 'starting_price', FILTER_SANITIZE_NUMBER_FLOAT);
        $categoryId = filter_input(INPUT_POST, 'category_id', FILTER_SANITIZE_NUMBER_INT);

        $am = new AuctionModel($this->getDatabaseConnection());

        $startsAt .= ':00';
        $endsAt   .= ':00';

        $startsAt = str_replace('T', ' ', $startsAt);
        $endsAt   = str_replace('T', ' ', $endsAt);

        $auctionId = $am->add([
            'title' => $title,
            'description' => $description,
            'starts_at' => $startsAt,
            'ends_at' => $endsAt,
            'starting_price' => $startingPrice,
            'category_id' => $categoryId,
            'image_path' => rand(1000, 9999),
            'user_id' => $this->getSession()->get('userId')
        ]);

        if (!$auctionId) {
            $this->set('message', 'Došlo je do greške prilikom dodavanja nove aukcije.');
            return;
        }

        if (!$this->doUpload('image', $auctionId)) { 
            return;
        }

        \ob_clean();
        header('Location: ' . BASE . 'category/' . $categoryId);
        exit;
    }

    private function checkAuctionAvailability($id) {
        $am = new AuctionModel($this->getDatabaseConnection());

        $auction = $am->getById($id);

        if (!$auction) {
            \ob_clean();
            header('Location: ' . BASE . 'user/dashboard');
            exit;
        }

        if ($auction->user_id != $this->getSession()->get('userId')) {
            \ob_clean();
            header('Location: ' . BASE . 'user/dashboard');
            exit;
        }

        $auction->starts_at = str_replace(' ', 'T', \substr($auction->starts_at, 0, -3));
        $auction->ends_at   = str_replace(' ', 'T', \substr($auction->ends_at, 0, -3));

        $this->set('auction', $auction);
    }

    public function getEdit($id) {
        $this->checkAuctionAvailability($id);

        $this->getAdd();
    }

    public function postEdit($id) {
        $this->checkAuctionAvailability($id);

        $title = filter_input(INPUT_POST, 'title', FILTER_SANITIZE_STRING);
        $description = filter_input(INPUT_POST, 'description', FILTER_SANITIZE_STRING);
        $startsAt = filter_input(INPUT_POST, 'starts_at', FILTER_SANITIZE_STRING);
        $endsAt = filter_input(INPUT_POST, 'ends_at', FILTER_SANITIZE_STRING);
        $startingPrice = filter_input(INPUT_POST, 'starting_price', FILTER_SANITIZE_NUMBER_FLOAT);
        $categoryId = filter_input(INPUT_POST, 'category_id', FILTER_SANITIZE_NUMBER_INT);

        $am = new AuctionModel($this->getDatabaseConnection());

        $startsAt .= ':00';
        $endsAt   .= ':00';

        $startsAt = str_replace('T', ' ', $startsAt);
        $endsAt   = str_replace('T', ' ', $endsAt);

        $res = $am->editById($id, [
            'title' => $title,
            'description' => $description,
            'starts_at' => $startsAt,
            'ends_at' => $endsAt,
            'starting_price' => $startingPrice,
            'category_id' => $categoryId
        ]);

        if (!$res) {
            $this->set('message', 'Došlo je do greške prilikom izmene ove aukcije.');
            return;
        }

        \ob_clean();
        header('Location: ' . BASE . 'auction/' . $id);
        exit;
    }
}
