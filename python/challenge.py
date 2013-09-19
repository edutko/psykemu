""" Converts a typed password into a key for a YubiKey-protected Password Safe
safe.

Given a hex-encoded YubiKey secret and a Password Safe password, this program
will print the key used to unlock a Password Safe file that is protected by the
password and a YubiKey with this secret. The printed string can be typed
directly into Password Safe (without using the YubiKey) to unlock the safe.
"""

__author__ = "Eric Dutko"
__license__ = "Apache License 2.0"
__version__ = "1.0"
__status__ = "Development"

import getpass
import hashlib
import hmac
from binascii import unhexlify

SHA1_BLOCK_SIZE = 64

yubikey_secret = getpass.getpass('YubiKey secret: ');
password = getpass.getpass(); 

key = unhexlify(yubikey_secret);

data = password.encode('utf-16le');
if (len(data) > SHA1_BLOCK_SIZE):
    data = data[:SHA1_BLOCK_SIZE];

# There are some quirks in the YubiKey implementation of SHA1 HMAC and the way
# Password Safeuses it. This block accounts for them.
if (len(data) == 0):
    data = b'\x00';
elif (data[-1] == 0x00):
    # If the last byte in the challenge is 0, the YubiKey drops it and any
    # immediately-preceeding 0s before calculating the HMAC.
    for i in range(len(data) - 1, -1, -1):
        if (data[i] != 0x00):
            break
    data = data[:i+1];
elif (len(data) == SHA1_BLOCK_SIZE):
    # If the challenge is exactly 64 bytes, the YubiKey assumes that the data is
    # padded with whatever the last byte is. It removes this byte and all
    # adjacent bytes of the same value.
    lastByte = data[-1];
    for i in range(len(data) - 1, -1, -1):
        if (data[i] != lastByte):
            break;
    data = data[:i + 1];

response = hmac.new(key, data, hashlib.sha1).hexdigest();
print('\nYour Password Safe password is:');
print(response);
