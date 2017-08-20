from web3 import Web3, HTTPProvider, IPCProvider
import web3


# connect to local node
w3 = Web3(HTTPProvider('http://localhost:8545'))

w3_contract = web3.contract.Contract('address of contract')

# uploads hash
w3_contract.transact().addEntry('someaddr', 'somehash', 'somechecksum')