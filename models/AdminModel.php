<?php
    namespace App\Models;

    use App\Core\Model;
    use App\Core\Field;
    use App\Validators\DateTimeValidator;
    use App\Validators\NumberValidator;
    use App\Validators\StringValidator;
    use App\Validators\BitValidator;

    class AdminModel extends Model {
        protected function getFields() {
            return [
                'admin_id'        => new Field(
                                    (new NumberValidator())
                                        ->setInteger()
                                        ->setUnsigned()
                                        ->setMaxIntegerDigits(11), false),
                'registered_at'     => new Field(new DateTimeValidator(), false),
                'username'       => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(64)),
                'password'  => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(128)),
                'email'          => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(255)),
                'forename'       => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(64)),
                'surname'        => new Field(
                                        (new StringValidator())
                                            ->setMinLength(1)
                                            ->setMaxLength(64)),
                'is_active'      => new Field(new BitValidator())
            ];
        }
    }
