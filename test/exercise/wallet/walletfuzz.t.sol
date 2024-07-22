// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "src/exercise/wallet/wallet.sol";
contract WalletTest is Test {

    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }
    function test_WalletReceive(uint256 amount) public
    {
        vm.assume(amount > 0.1 ether);
        address _address= vm.addr(1);
        //uint256 amount=100;
        vm.deal(_address, amount);
        uint256 startBalance = address(wallet).balance;
        console.log(startBalance);
        vm.startPrank(_address);
        console.log(address(this).balance);
        (bool success, ) = address(wallet).call{value: amount}("");
        require(success, "Receive failed");
        vm.stopPrank();
        uint256 endBalance = address(wallet).balance;
        console.log(endBalance);
        assertEq(startBalance+amount, wallet.getBalance());
    }
    function testfailedAddAllowedWithdrawers(address address1,address address2,address address3,address address4) public
    {
       wallet.addAllowedWithdrawers(address1);
       wallet.addAllowedWithdrawers(address2);
       wallet.addAllowedWithdrawers(address3);
       vm.expectRevert();
       wallet.addAllowedWithdrawers(address4);

    }

      function test_isnotOwner(address _address) public
    {
       address checkAddress= vm.addr(1);
       vm.startPrank(checkAddress);
       vm.expectRevert();
       wallet.addAllowedWithdrawers(_address);
     }

    function test_isOwner(address _address) public
    {
       wallet.addAllowedWithdrawers(_address);
    }

    function test_AddAllowedWithdrawers(address _address) public
    {
       wallet.addAllowedWithdrawers(_address);
       assertEq(wallet.allowedWithdrawers(_address), 1);
    }

    function test_changeAllowedWithdrawers(address _address, address newAddress) public
    {
        wallet.addAllowedWithdrawers(_address);
        wallet.changeAllowedWithdrawers(_address,newAddress);
        assertEq(wallet.allowedWithdrawers(newAddress), 1);
    }

    function test_withdraw(uint256 amount) public
    {
       address _address=vm.addr(1);
       console.log(amount);
       wallet.addAllowedWithdrawers(_address);
       vm.deal(address(wallet), amount);
       vm.prank(_address);
       wallet.withdraw(amount);
    }

    function test_IsOwnerOrAllowed(uint256 amount) public
    {   vm.assume(amount > 0.1 ether);
        address checkAddress= vm.addr(1);
        vm.deal(checkAddress, amount);
        vm.deal(address(wallet), amount);
        vm.startPrank(checkAddress);
        vm.expectRevert();
        wallet.withdraw(amount);

    }
}
