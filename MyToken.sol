// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "./@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/// @custom:security-contact hello@publicaudiovisual.com
contract MyToken is Initializable, ERC1155Upgradeable, AccessControlUpgradeable {
    bytes32 public constant URI_SETTER_ROLE = keccak256("URI_SETTER_ROLE");

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC1155_init("https://publicaudiovisual.com/");
        __AccessControl_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(URI_SETTER_ROLE, msg.sender);
    }

    function setURI(string memory newuri) public onlyRole(URI_SETTER_ROLE) {
        _setURI(newuri);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC1155Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
