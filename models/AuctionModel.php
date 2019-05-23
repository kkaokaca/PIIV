<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\NumberValidator;
    use App\Validators\DateTimeValidator;
    use App\Validators\StringValidator;
    use App\Validators\BitValidator;

    class AuctionModel extends Model {
        protected function getFields() {
            return [
                'auction_id'     => new Field(
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
                'starting_price' => new Field((new NumberValidator())->setUnsigned()),
                'starts_at'      => new Field(new DateTimeValidator()),
                'ends_at'        => new Field(new DateTimeValidator()),
                'is_active'      => new Field(new BitValidator()),
                'category_id'    => new Field(
                                        (new NumberValidator())
                                            ->setInteger()
                                            ->setUnsigned()
                                            ->setMaxIntegerDigits(11)),
                'user_id'        => new Field(
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

        public function isActive($auction) {
            if (!$auction) {
                return false;
            }

            if ($auction->is_active == 0) {
                return false;
            }

            /*if ( \strtotime($auction->starts_at) > time() ) {
                return false;
            }

            if ( \strtotime($auction->ends_at) < time() ) {
                return false;
            }*/

            return true;
        }

        public function getAllActiveBySearch($keyword) {
            $sql = 'SELECT
                        *
                    FROM
                        auction
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
    }
