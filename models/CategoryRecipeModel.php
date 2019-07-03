<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\NumberValidator;


    class CategoryRecipeModel extends Model {
        protected function getFields() {
            return [
                'category_recipe_id'        => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11), false),
        }
    }
