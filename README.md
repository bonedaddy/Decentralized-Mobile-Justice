# decentralized-police-enforcement

Several years ago there was a project done along with ACLU (around the time of the Eric Gardner police brutality case) to build a system where users could stream footage a police incident, and store it locally on their phone, but also stream it to remote servers in case the phone was compromised and video evidence deleted. This was a great project but it suffered from one problem: decentralization. For whatever reason it appears the project is now defunct, so in essence this is a reboot of that project, but instead of storing the data on central servers, it will be stores usaing a distributed, and decentralized filesystem protocol called IPFS (this may change in the future) to s tore the data. This data will then be checksum, and the checksum will be uploaded to the ethereum blockchain in an immutable storage container of a smart contract this way when viewing the video you can run a checksum, and compare the hash with a known good, and non-changeable hash which will help verify video authenticity (this verification system will likely chnage and become more advanced as time goes on)

It will feature a token which will be used as an incentive system for uploading videos, and for running a not yet constructed **citadel** server whiich will maintain a local backup of every video uploaded. 

# Files

## data_receive_contract.sol

This is the contract that is used to store IPFS hash, checksum, and recorder information.
It wil also calculate an amount of the CopCoin token to be credited to the video uploader

## server.py

Incredibly basic, not tested, and still in development mini mockup server of the actual server app which will most likely be written in NodeJS or Python 3.

## main.sol

What will be the ipfs or citadel smart contract conde, and admin control