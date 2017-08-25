from web3 import Web3, HTTPProvider, IPCProvider
import web3
import ipfsapi
import hashlib
import sys

class WWeb3():

    def __init__(self,tokenContractAddress, localparityip, localparityport):
        self.w3 = Web3(HTTPProvider('http://%:%' % (localparityip, localparityport)))
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
    pass
elif len(sys.argv) > 6 or len(sys.argv) < 6:
    print('Incorrect invocation\nUsage: python3 server.py <tokenContractAddr> <ipfsnodeip> <ipfsnodeport> <localparityip> <localparityport>')
    exit()



ipfsctl = Ipfs(sus.argv[2], sys.argv[3])
# first we instantiate the IPFS class with the ip and port of our ipfs node
# the node information w ill be hardcoded

# program will need the user to specify the ipfs port and ip, as well as parity node and ip in the following format:

# python3 server.py tokenContractaddress ipfsNodeIp ipfsNodePort localparityip localparityport
web3ctl, ipfsctl = init(tokenContractAddress=sys.argv[1], ipfsNodeIp=sys.argv[2], ipfsNodePort=sys.argv[3], localparityip=sys.argv[4], localparityport=sys.argv[5])
print("Welcome to the DMJs python control server interface [BETA]\nPlease utilize the following menu system")

menu_dict = {'[1] Upload file to IPFS' : ['yes', 'no'],  '[2] Upload file to IPFS, and send integrity data to the blockchain' : ['yes', 'no']}

"""
while True;
    options = []
    for key in menu_dict.keys():
        print('%s - %s %s' % (key, menu_dict[key][0], menu_dict[key][1])
    option = int(input('Please enter the number of the corresponding option'))
    swxiaion = input("Please type yes, or no to make your decision")
"""

filename = input('specify the file to upload to ipfs: ')

# Now lets upload the file to IPFS, returning the hash identifier
hash = ipfsctl.uploadFile(filename)
print("Here is the ipfs identifier for your file:: %s hash")
#continueYN = input('Do you wish to continue and upload a checksum to ethereum, or do you want to exit now? please say yes or no")

#if continueYN == 'yes':

