#!/bin/bash

# A very simple script to generate a few public and private keys and addresses.

#############
## Sender. ##
#############

seed=$(bx seed -b 256)
senderPrivateKey=$(bx ec-new $seed)
senderPublicKey=$(bx ec-to-public -u $senderPrivateKey)

extended=6f$(bx ripemd160 $(bx sha256 $senderPublicKey))
checksum=$(bx sha256 $(bx sha256 $extended) | cut -b 1-8)
senderAddress=$(bx base58-encode $extended$checksum)

echo 
echo " # SENDER "
echo "
export senderPrivateKey=$senderPrivateKey
export senderPublicKey=$senderPublicKey
export senderAddress=$senderAddress
"

###############
## Receiver. ##
###############

seed=$(bx seed -b 256)
receiverPrivateKey=$(bx ec-new $seed)
receiverPublicKey=$(bx ec-to-public -u $receiverPrivateKey)

extended=6f$(bx ripemd160 $(bx sha256 $receiverPublicKey))
checksum=$(bx sha256 $(bx sha256 $extended) | cut -b 1-8)
receiverAddress=$(bx base58-encode $extended$checksum)

echo
echo " # RECEIVER "
echo "
export receiverPrivateKey=$receiverPrivateKey
export receiverPublicKey=$receiverPublicKey
export receiverAddress=$receiverAddress
"
