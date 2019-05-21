<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\StringValidator;
    use App\Validators\NumberValidator;

    class CategoryModel extends Model {
        protected function getFields() {
            return [
                'category_id' => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11), false),
                'name'        => new Field(
                                    (new StringValidator())
                                        ->setMinLength(1)
                                        ->setMaxLength(64))
            ];
        }

        public function getAllSorted() {
            $pdo = $this->getDatabaseConnection()->getConnection();
            $sql = 'SELECT * FROM category ORDER BY title DESC;';
            $prep = $pdo->prepare($sql);
            $items = [];

            if ($prep) {
                $res = $prep->execute();

                if ($res) {
                    $items = $prep->fetchAll(PDO::FETCH_OBJ);
                }
            }

            return $items;
        }
    }
