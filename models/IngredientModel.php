<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\NumberValidator;
    use App\Validators\DateTimeValidator;
    use App\Validators\StringValidator;
    use App\Validators\BitValidator;

    class IngredientModel extends Model {
        protected function getFields() {
            return [
                'ingredient_id'     => new Field(
                                        (new NumberValidator())
                                            ->setInteger()
                                            ->setUnsigned()
                                            ->setMaxIntegerDigits(11), false),
                'created_at'     => new Field(new DateTimeValidator(), false),
                'name'          => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(255)),
                'unit_measure'          => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(255)),
                
            ];
        }

        public function getAllByCategoryId(int $ingredientId): array {
            return $this->getAllByFieldName('ingredient_id', $ingredientId);
        }

    }
