// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ContextUpgradeable} from "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";

contract BlacklistableUpgradeable is Initializable, ContextUpgradeable {
    /// @custom:storage-location erc7201:fortesecurities.BlacklistableUpgradeable
    struct BlacklistableUpgradeableStorage {
        mapping(address => bool) blacklisted;
    }

    // keccak256(abi.encode(uint256(keccak256("fortesecurities.BlacklistableUpgradeable")) - 1)) & ~bytes32(uint256(0xff))
    bytes32 private constant BlacklistableUpgradeableStorageLocation =
        0x5e0ff3240a99a47c7048588bdf28d8ba221704144a1e0d3f41eececcdf2a1700;

    function _getBlacklistableUpgradeableStorage() private pure returns (BlacklistableUpgradeableStorage storage $) {
        assembly {
            $.slot := BlacklistableUpgradeableStorageLocation
        }
    }

    error Blacklisted(address account);

    function __Blacklistable_init() internal onlyInitializing {
        __Blacklistable_init_unchained();
    }

    function __Blacklistable_init_unchained() internal onlyInitializing {}

    /**
     * @dev Emitted when an `account` is blacklisted.
     */
    event Blacklist(address indexed account);

    /**
     * @dev Emitted when an `account` is removed from the blacklist.
     */
    event UnBlacklist(address indexed account);

    /**
     * @dev Throws if argument account is blacklisted
     * @param account The address to check
     */
    modifier notBlacklisted(address account) {
        if (isBlacklisted(account)) {
            revert Blacklisted(account);
        }
        _;
    }

    /**
     * @dev Checks if account is blacklisted
     * @param account The address to check
     */
    function isBlacklisted(address account) public view returns (bool) {
        BlacklistableUpgradeableStorage storage $ = _getBlacklistableUpgradeableStorage();
        return $.blacklisted[account];
    }

    /**
     * @dev Adds account to blacklist
     * @param account The address to blacklist
     */
    function _blacklist(address account) internal virtual {
        BlacklistableUpgradeableStorage storage $ = _getBlacklistableUpgradeableStorage();
        $.blacklisted[account] = true;
        emit Blacklist(account);
    }

    /**
     * @dev Removes account from blacklist
     * @param account The address to remove from the blacklist
     */
    function _unBlacklist(address account) internal virtual {
        BlacklistableUpgradeableStorage storage $ = _getBlacklistableUpgradeableStorage();
        $.blacklisted[account] = false;
        emit UnBlacklist(account);
    }
}
