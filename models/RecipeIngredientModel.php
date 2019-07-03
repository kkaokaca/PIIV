<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\NumberValidator;


    class RecipeIngredientModel extends Model {
        protected function getFields() {
            return [
                'recipe_ingredient_id'        => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11), false),
                'amount'        => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11)),
                
            ];
        }

        public function getRecipeByIngredientId($IngredientId) {
            $pdo = $this->getDatabaseConnection()->getConnection();



            $sql = 'SELECT `recipe`.`recipe_id` as recipe_id, `recipe`.`title` as recipe_title FROM recipe_ingredient
            LEFT JOIN recipe ON  recipe.recipe_id = recipe_ingredient.recipe_id
            WHERE recipe_ingredient.ingredient_id = ?;';
            $prep = $pdo->prepare($sql);
            $items = [];
            

            if ($prep) {
                $res = $prep->execute([$IngredientId]);

                if ($res) {
                    $items = $prep->fetchAll(\PDO::FETCH_OBJ);
                }
            }

            return $items;
        }
    }
