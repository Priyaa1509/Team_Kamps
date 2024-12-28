
pragma solidity ^0.5.16;

contract SimpleNFT {
    struct NFT {
        uint256 id;
        string tokenURI;
        address owner;
    }

    // Mapping from token ID to NFT
    mapping(uint256 => NFT) private nfts;
    // Mapping from owner to their token IDs
    mapping(address => uint256[]) private ownedTokens;
    // Mapping to track the number of NFTs owned by an address
    mapping(address => uint256) private ownedTokenCount;
    // Counter for the next token ID
    uint256 private nextTokenId;

    event NFTCreated(uint256 indexed tokenId, string tokenURI, address indexed owner);
    event NFTTransferred(uint256 indexed tokenId, address indexed from, address indexed to);

    // Constructor
    constructor() public {
        nextTokenId = 1; // Start token IDs from 1
    }

    // Function to mint a new NFT
    function mint(string memory _tokenURI) public {
        uint256 tokenId = nextTokenId;
        nfts[tokenId] = NFT(tokenId, _tokenURI, msg.sender);
        ownedTokens[msg.sender].push(tokenId);
        ownedTokenCount[msg.sender]++;
        nextTokenId++;

        emit NFTCreated(tokenId, _tokenURI, msg.sender);
    }

    // Function to transfer an NFT
    function transfer(address _to, uint256 _tokenId) public {
        require(nfts[_tokenId].owner == msg.sender, "You do not own this NFT");
        require(_to != address(0), "Invalid address");

        // Transfer the NFT
        nfts[_tokenId].owner = _to;

        // Update the ownedTokens mapping
        _removeTokenFromOwner(msg.sender, _tokenId);
        ownedTokens[_to].push(_tokenId);
        ownedTokenCount[_to]++;
        ownedTokenCount[msg.sender]--;

        emit NFTTransferred(_tokenId, msg.sender, _to);
    }

    // Function to retrieve the token URI
    function tokenURI(uint256 _tokenId) public view returns (string memory) {
        require(_exists(_tokenId), "NFT does not exist");
        return nfts[_tokenId].tokenURI;
    }

    // Internal function to check if an NFT exists
    function _exists(uint256 _tokenId) internal view returns (bool) {
        return nfts[_tokenId].owner != address(0);
    }

    // Internal function to remove a token from an owner's list
    function _removeTokenFromOwner(address _owner, uint256 _tokenId) internal {
        uint256[] storage tokens = ownedTokens[_owner];
        for (uint256 i = 0; i < tokens.length; i++) {
            if (tokens[i] == _tokenId) {
                tokens[i] = tokens[tokens.length - 1]; // Replace with the last token
                tokens.pop(); // Remove the last token
                break;
            }
        }
    }

    // Function to get the number of NFTs owned by an address
    function balanceOf(address _owner) public view returns (uint256) {
        return ownedTokenCount[_owner];
    }

    // Function to get the owner of a specific NFT
    function ownerOf(uint256 _tokenId) public view returns (address) {
        require(_exists(_tokenId), "NFT does not exist");
        return nfts[_tokenId].owner;
    }
}