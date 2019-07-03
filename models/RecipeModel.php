<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\NumberValidator;
    use App\Validators\DateTimeValidator;
    use App\Validators\StringValidator;
    use App\Validators\BitValidator;

    class RecipeModel extends Model {

        public function getCategoriesByRecipeId($id): array {
            return $this-> getAllByFieldNameMtoN('recipe_id', $id); 
        }


        protected function getFields() {
            return [
                'recipe_id'     => new Field(
                                        (new NumberValidator())
                                            ->setInteger()
                                            ->setUnsigned()
                                            ->setMaxIntegerDigits(11), false),
                'created_at'     => new Field(new DateTimeValidator(), false),
                'title'          => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(255)),
                'description'    => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(64000)),
                
                'admin_id'        => new Field(
                                        (new NumberValidator())
                                            ->setInteger()
                                            ->setUnsigned()
                                            ->setMaxIntegerDigits(11)),
                'image_path'     => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(255))
            ];
        }

        public function getAllByCategoryId(int $categoryId): array {
            return $this->getAllByFieldName('category_id', $categoryId);
        }
        

        public function getAllActiveBySearch($keyword) {
            $sql = 'SELECT
                        *
                    FROM
                        recipe
                    WHERE
                        title LIKE ? AND
                        starts_at <= NOW() AND
                        ends_at >= NOW() AND
                        is_active = 1;';
            
            $prep = $this->getDatabaseConnection()->getConnection()->prepare($sql);

            $res = $prep->execute([ '%' . $keyword . '%' ]);

            if ($res) {
                return $prep->fetchAll(\PDO::FETCH_OBJ);
            }

            return [];
        }

        public function getRecipeIngredientDetailById($recipeId) {
            $pdo = $this->getDatabaseConnection()->getConnection();

            $sql = 'SELECT `ingredient`.`ingredient_id` as `ingredient_id`, `recipe_ingredient`.`amount` as `amount` ,`ingredient`.`name` as ingredient_name, `ingredient`.`unit_measure` as ingredient_unit FROM recipe_ingredient
            LEFT JOIN ingredient ON  ingredient.ingredient_id = recipe_ingredient.ingredient_id
            WHERE recipe_ingredient.recipe_id = ?;';
            $prep = $pdo->prepare($sql);
            $items = [];
            

            if ($prep) {
                $res = $prep->execute([$recipeId]);

                if ($res) {
                    $items = $prep->fetchAll(\PDO::FETCH_OBJ);
                }
            }

            return $items;
        }

        public function getAllSorted() {
            $pdo = $this->getDatabaseConnection()->getConnection();
            $sql = 'SELECT * FROM recipe ORDER BY title DESC;';
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
