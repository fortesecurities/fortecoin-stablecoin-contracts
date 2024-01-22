// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ERC20Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import {BlacklistableUpgradeable} from "./BlacklistableUpgradeable.sol";

contract ERC20BlacklistableUpgradeable is Initializable, ERC20Upgradeable, BlacklistableUpgradeable {
    function __ERC20Blacklistable_init() internal onlyInitializing {
        __Blacklistable_init();
    }

    function __ERC20Blacklistable_init_unchained() internal onlyInitializing {}

    function _update(
        address from,
        address to,
        uint256 value
    ) internal virtual override notBlacklisted(from) notBlacklisted(to) {
        super._update(from, to, value);
    }
}
