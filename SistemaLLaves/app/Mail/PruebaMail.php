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
    public $destinatario;
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
        $name = 'Jose Munguia';
        return $this->view('emails.prueba')
                    ->from($address,$name)
                    ->subject($this->data['subject'])
                    ->with('mensaje',$this->data['mensaje']);
    }
}
