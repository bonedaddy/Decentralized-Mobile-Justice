# decentralized-police-enforcement

Several years ago there was a project done along with ACLU (around the time of the Eric Gardner police brutality case) to build a system where users could stream footage a police incident, and store it locally on their phone, but also stream it to remote servers in case the phone was compromised and video evidence deleted. This was a great project but it suffered from one problem: centralization. For whatever reason it appears the project is now defunct, so in essence this is a reboot of that project, but instead of storing the data on central servers, it will be stores usaing a distributed, and decentralized filesystem protocol called IPFS (this may change in the future) to store the data. This data will then be checksumed, and the checksum will be uploaded to the ethereum blockchain in an immutable storage container of a smart contract this way when viewing the video you can run a checksum, and compare the hash with a known good, and non-changeable hash which will help verify video authenticity (this verification system will likely change and become more advanced as time goes on)

It will feature a token which will be used as an incentive system for uploading videos, and for running a not yet constructed **citadel** server which will maintain a local backup of every video uploaded. 

# Project Road Map

As of this moment, there is no set roadmap with specific dates. However this is an open-source, and volunteer based project where anyone is allowed to contribute. Once there is a fully working prototype, I will be crowdfunding this project so that I can hire developers so we can churn out a production ready product. Everyone who was part of the project during the initial (current) development phase, will be offered a paid development position, with pay equivalent to the work done.

# Volunteers Needed For

* NodeJS server which will act as a "citadel" server which maintains a local copy of every file uploaded this server. Integrate with Ethereum so that people running Citadel servers will be credited with a token.
* NodeJS servers that optimally can be browserified so that it can be run off a single HTML page. This server will accept incoming video streams, saving the video to IPFS, and then calling a smart contract to upload the checksum/integrity check to immutable storage
* Mobile application that will stream video to a randomly select NodeJS server, and once done recording saves video locally. Must also integrate with ethereum, as users will be identified by eth addresses, and will be given a token to act as an incentive for vdieo recording
* Website design for both the project website, and html pages people will be using
* NOTE: I (postables) will be handling all smart contract development

## data_receive_contract.sol

This is the contract that is used to store IPFS hash, checksum, and recorder information.
It wil also calculate an amount of the CopCoin token to be credited to the video uploader

## server.py

Incredibly basic, not tested, and still in development mini mockup server of the actual server app which will most likely be written in NodeJS or Python 3.

## main.sol

What will be the ipfs or citadel smart contract code, and admin control
