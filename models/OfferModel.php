<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\NumberValidator;
    use App\Validators\DateTimeValidator;

    class OfferModel extends Model {
        protected function getFields() {
            return [
                'offer_id'    => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11), false),
                'created_at'  => new Field(new DateTimeValidator(), false),
                'auction_id'  => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11)),
                'user_id'     => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11)),
                'price'       => new Field((new NumberValidator())->setUnsigned())
            ];
        }

        public function getAllByAuctionId(int $auctionId): array {
            return $this->getAllByFieldName('auction_id', $auctionId);
        }
    }
