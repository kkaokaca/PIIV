<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\StringValidator;
    use App\Validators\NumberValidator;
    use App\Validators\DateTimeValidator;

    class CategoryModel extends Model {


        public function getRecipesByCategoryId($id): array {
            return $this-> getAllByFieldNameMtoN('category_id', $id);
        }

        protected function getFields() {
            return [
                'category_id' => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(10), false),

                'created_at'        => new Field(new DateTimeValidator(), false),

                'name'              => new Field(
                                    (new StringValidator())
                                        ->setMinLength(1)
                                        ->setMaxLength(64)),

                'admin_id'        => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(10))
            ];
        }

        public function getAllSorted() {
            $pdo = $this->getDatabaseConnection()->getConnection();
            $sql = 'SELECT * FROM category ORDER BY name DESC;';
            $prep = $pdo->prepare($sql);
            $items = [];

            if ($prep) {
                $res = $prep->execute();

                if ($res) {
                    $items = $prep->fetchAll(\PDO::FETCH_OBJ);
                }
            }

            return $items;
        }
    }
