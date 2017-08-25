from web3 import Web3, HTTPProvider, IPCProvider
import web3
import ipfsapi
import hashlib
import sys

class WWeb3():

    def __init__(self):
        self.w3 = Web3(HTTPProvider('http://localhost:8545'))

        self.w3_contract = web3.eth.Contract(tokenContractaddress) 
        # create hashlib handler for sha256
        self.hasher = hashlib.blake2b()
        # to use this we would do something like so:
        # self.hasher.update(b'ipfs hash')
        # to return: self.hasher.hexdigest()

    

    def addChecksum(self,recorder, ipfshash):
        checksum = self.hasher.update(b'%s' % ipfshash)
        self.w3_contract.transact().addEntry(str(recorder), str(ipfshash), str(checksum))


class Ipfs():

    def __init__(self, ip, port):
        self.ipfs_api = ipfsapi.connect(ip, port)

    
    def uploadFile(self, objectID):
        response = self.ipfs_api.add(objectID)
        ipfshash = self.ipfs_api.cat(response['Hash']).strip('\n')
        return ipfshash

def storeToIpfsAndSaveChecksum(ipfsHashID):
    ipfshash = ipfss.uploadFile(ipfsHashID)
    webb3.addChecksum(recorder, ipfshash)



# add a check to ensure the user provided enough params:
if len(sys.argv) == 6:
    print('You have provided the correct number of arguments')
elif len(sys.argv) > 6 or len(sys.argv) < 6:
    print('Incorrect invocation\nUsage: python3 server.py <tokenContractAddr> <ipfsnodeip> <ipfsnodeport> <localparityip> <localparityport>')
    exit()



ipfsctl = Ipfs(sys.argv[2], sys.argv[3])

web3ctl = WWeb3()
# first we instantiate the IPFS class with the ip and port of our ipfs node
# the node information w ill be hardcoded

# program will need the user to specify the ipfs port and ip, as well as parity node and ip in the following format:

# python3 server.py tokenContractaddress ipfsNodeIp ipfsNodePort localparityip localparityport


ipfsctl.uploadFile('test.txt')

# Now lets upload the file to IPFS, returning the hash identifier
hash = ipfsctl.uploadFile(filename)
print("Here is the ipfs identifier for your file:: %s hash")
#continueYN = input('Do you wish to continue and upload a checksum to ethereum, or do you want to exit now? please say yes or no")

#if continueYN == 'yes':

