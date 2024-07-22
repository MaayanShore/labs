//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "src/libs/safemath.sol";

contract Math {
    using SafeMath for uint256;

    uint256 private constant EXP_SCALE = 1e18;
    uint256 private constant HALF_EXP_SCALE = EXP_SCALE / 2;

    function getExp(uint256 num, uint256 denom)
        internal
        pure
        returns (uint256)
    {
         uint256 scaledNumber = num.mul(EXP_SCALE);
        //if (!successMul) return 0;
         uint256 rational = scaledNumber.div(denom);
       // if (!successDiv) return 0;
        return rational;
    }

    function mulExp(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 doubleScaledProduct = a.mul(b);
       // if (!successMul) return 0;
        
            uint256 doubleScaledProductWithHalfScale
         = HALF_EXP_SCALE.add(doubleScaledProduct);
       // if (!successAdd) return 0;
         uint256 product = doubleScaledProductWithHalfScale
            .div(EXP_SCALE);
        //assert(successDiv == true);
        return product;
    }

    function percentage(uint256 _num, uint256 _percentage)
        internal
        pure
        returns (uint256)
    {
        uint256 rational = getExp(_num, 5);
        return mulExp(rational, _percentage);
    }
}
