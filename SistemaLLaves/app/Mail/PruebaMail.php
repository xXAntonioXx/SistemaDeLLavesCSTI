<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class PruebaMail extends Mailable
{
    use Queueable, SerializesModels;

    public $data;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($data)
    {
        $this->data=$data;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $address = 'jose_antony11@hotmail.com';
        $subject = 'probando SendGrid';
        $name = 'Jose Munguia';
        return $this->view('emails.prueba')
                    ->from($address,$name)
                    ->cc($address,$name)
                    ->bcc($address,$name)
                    ->replyTo($address,$name)
                    ->subject($subject)
                    ->with('mensaje',$this->data['mensaje']);
    }
}
