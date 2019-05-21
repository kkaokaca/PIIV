<?php
namespace App\Controllers;

use App\Models\CategoryModel;
use App\Core\Controller;
use App\Models\AuctionModel;
use App\Models\UserModel;
use App\Validators\StringValidator;

class MainController extends Controller {
    public function home() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $categories = $cm->getAll();
        
        $this->set('categories', $categories);
    }

    public function categoriesSortedById() {
        $cm = new CategoryModel($this->getDatabaseConnection());
        $categories = $cm->getAll();

        usort($categories, function($a, $b) {
            return $b->name <=> $a->name;
        });

        $this->set('categories', $categories);
    }

    public function showCategoryAuctions($categoryId) {
        $am = new AuctionModel($this->getDatabaseConnection());
        $auctions = $am->getAllByCategoryId($categoryId);
        $this->set('auctions', $auctions);

        $cm = new CategoryModel($this->getDatabaseConnection());
        $category = $cm->getById($categoryId);
        $this->set('category', $category);
    }

    public function loginGet() {

    }

    public function loginPost() {
        $username = filter_input(INPUT_POST, 'username', FILTER_SANITIZE_STRING);
        $password = filter_input(INPUT_POST, 'password', FILTER_SANITIZE_STRING);

        $um = new UserModel($this->getDatabaseConnection());

        $user = $um->getByFieldName('username', $username);

        if (!$user) {
            sleep(1);
            $this->set('message', 'Losi podaci!');
            return;
        }

        if (!password_verify($password, $user->password_hash)) {
            sleep(1);
            $this->set('message', 'Losi podaci!');
            return;
        }

        $this->getSession()->put('userId', $user->user_id);

        \ob_clean();
        header('Location: ' . BASE . 'user/dashboard/');
        exit;
    }

    public function getRegister() {
        
    }

    public function postRegister() {
        $username  = filter_input(INPUT_POST, 'reg_username', FILTER_SANITIZE_STRING);
        $email     = filter_input(INPUT_POST, 'reg_email', FILTER_SANITIZE_EMAIL);
        $forename  = filter_input(INPUT_POST, 'reg_forename', FILTER_SANITIZE_STRING);
        $surname   = filter_input(INPUT_POST, 'reg_surname', FILTER_SANITIZE_STRING);
        $password1 = filter_input(INPUT_POST, 'reg_password_1', FILTER_SANITIZE_STRING);
        $password2 = filter_input(INPUT_POST, 'reg_password_2', FILTER_SANITIZE_STRING);

        if ($password1 != $password2) {
            $this->set('message', 'Morate dva puta da potvrdite istu lozinku.');
            return;
        }

        $validator = (new StringValidator())->setMinLength(6)->setMaxLength(120);
        if (! $validator->isValid($password1)) {
            $this->set('message', 'Lozinka mora imati najmanje 6 karaktera i najvise 120 karaktera.');
            return;
        }

        $um = new UserModel($this->getDatabaseConnection());

        $user = $um->getByFieldName('username', $username);
        if ($user) {
            $this->set('message', 'Korisničko ime je zauzeto.');
            return;
        }

        $user = $um->getByFieldName('email', $email);
        if ($user) {
            $this->set('message', 'Sa tom adresom e-pošte već postoji nalog.');
            return;
        }

        $passwrodHash = password_hash($password1, PASSWORD_DEFAULT);

        $userId = $um->add([
            'username' =>      $username,
            'password_hash' => $passwrodHash,
            'email' =>         $email,
            'forename' =>      $forename,
            'surname' =>       $surname
        ]);

        if (!$userId) {
            $this->set('message', 'Došlo je do greške prilikom registracije naloga.');
            return;
        }

        $this->set('message', 'USPEŠNO je registrovan nalog. Možete da se prijavite sada.');
    }
}
