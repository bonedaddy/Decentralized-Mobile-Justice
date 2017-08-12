import ipfsapi, ethjsonrpc, sys


def help():
    print('Proper invocation: python_ipfs.py <file-source> <upload-identifier> <function-execute')
    print('EX: python_ipfs.py test.txt "test file" uploadHash')
if len(sys.argv) < 3:
    exit()
elif len(sys.argv) > 3:
    exit()
else:
    print('Correct number of arguments')
ipfs = ipfsapi.connect('127.0.0.1', 5001)

# we must connect to the locally running ethereum node
eth_node = ethjsonrpc.EthJsonRpc('127.0.0.1', 8545)


# here we willl the particular function that the user requested, which in this case is storing the data
output = ipfs.add(sys.argv[0])
hash_id = string(output['Hash'][2::45])1


if sys.argv[2] == 'uploadHash':
    try:
        transaction = eth_node.call_with_transaction(eth_node.coinbase(), contract_address, 'uploadHash(%s, %s)' % (identifier, hash_id))
        if len(transaction) <= 0:
                print('We have come across an error during function initialization')
                exit()
    except Exception as e:
        print('Error %s occured' % e)