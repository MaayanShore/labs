// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.0;
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// interface ILendingPool {
//     function deposit(
//         address asset,
//         uint256 amount,
//         address onBehalfOf,
//         uint16 referralCode
//     ) external;

//     function withdraw(
//         address asset,
//         uint256 amount,
//         address to
//     ) external returns (uint256);
// }
// interface IWETHGateway {
//     function depositETH(
//         address lendingPool,
//         address onBehalfOf,
//         uint16 referralCode
//     ) external payable;

//     function withdrawETH(
//         address lendingPool,
//         uint256 amount,
//         address onBehalfOf
//     ) external;
// }
// library AaveLibrary {
// ILendingPool public constant aave =
// ILendingPool(0xE0fBa4Fc209b4948668006B2bE61711b7f465bAe);
//   IERC20 public constant dai =
//         IERC20(0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD);
//     IWETHGateway public constant wethGateway =
//         IWETHGateway(0xA61ca04DF33B72b235a8A28CfB535bb7A5271B70);
//             IERC20 public constant aWeth =
//         IERC20(0x87b1f4cf9BD63f7BBD3eE1aD04E8F52540349347);
//     function _sendDaiToAave(uint256 _amount,address lending) internal {
//         dai.approve(address(aave), _amount);
//         aave.deposit(address(dai), _amount, lending, 0);
//     }

//     function _withdrawDaiFromAave(uint256 _amount,address sender) internal {
//         aave.withdraw(address(dai), _amount, sender);
//     }

//     function _sendWethToAave(uint256 _amount,address lending) internal {
//         wethGateway.depositETH{value: _amount}(address(aave), lending, 0);
//     }

//     function _withdrawWethFromAave(uint256 _amount,address lending) internal {
//         aWeth.approve(address(wethGateway), _amount);
//         wethGateway.withdrawETH(address(aave), _amount, lending);
//     }


// }