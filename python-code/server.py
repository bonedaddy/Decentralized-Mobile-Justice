from web3 import Web3, HTTPProvider, IPCProvider
import web3
import ipfsapi
import hashlib
import sys

class WWeb3():

    def __init__(tokenContractAddress, localparityip, localparityport):
        self.w3 = Web3(HTTPProvider('http://%:%' % (localparityip, localparityport)))
        self.w3_contract = web3.eth.Contract(tokenContractaddress) 
        # create hashlib handler for sha256
        self.hasher = hashlib.blake2b()
        # to use this we would do something like so:
        # self.hasher.update(b'ipfs hash')
        # to return: self.hasher.hexdigest()

    

    def addChecksum(recorder, ipfshash):
        checksum = self.hasher.update(b'%s' % ipfshash)
        self.w3_contract.transact().addEntry(str(recorder), str(ipfshash), str(checksum))


class Ipfs():

    def __init__(ip, port):
        self.ipfs_api = ipfsapi.connect(ip, port)

    
    def uploadFile(objectID):
        response = self.ipfs_api.add(objectID)
        ipfshash = self.ipfs_api.cat(response['Hash']).strip('\n')
        return ipfshash




# This function takes care of instantiating all the necessary classes
def init(tokenContractAddress, ipfsNodeIp, ipfsNodePort, localparityip, localparityport):
    webb3 = WWeb3(tokenContractAddress, localparityip, localparityport)
    ipfss = Ipfs(ipfsNodeIp, ipfsNodePort)
    return webb3, ipfss


def storeToIpfsAndSaveChecksum():
    ipfshash = ipfss.uploadFile('some id')
    webb3.addChecksum(recorder, ipfshash)



# add a check to ensure the user provided enough params:
if len(sys.argv) == 6:
    pass
elif len(sys.argv) > 6 or len(sys.argv) < 6:
    print('Incorrect invocation\nUsage: python3 server.py <tokenContractAddr> <ipfsnodeip> <ipfsnodeport> <localparityip> <localparityport>')
    exit()

# first we instantiate the IPFS class with the ip and port of our ipfs node
# the node information w ill be hardcoded

# program will need the user to specify the ipfs port and ip, as well as parity node and ip in the following format:

# python3 server.py tokenContractaddress ipfsNodeIp ipfsNodePort localparityip localparityport
web3ctl, ipfsctl = init(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5])
print("Welcome to the DMJs python control server interface [BETA]\nPlease utilize the following menu system")

menu_dict = {'[1] Upload file to IPFS' : ['yes', 'no'], }
while True;
    for enum
