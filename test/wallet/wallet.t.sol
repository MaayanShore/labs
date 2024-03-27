
// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;
import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "@hack/wallet/wallet.sol";
contract WalletTest is Test {

    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }
    function test_WalletReceive() public
    {
        address checkAddress= vm.addr(1);
        uint256 amount=100;
        vm.deal(checkAddress, amount);
        uint256 startBalance = address(wallet).balance;
        console.log(startBalance);
        vm.startPrank(checkAddress);
        console.log(address(this).balance);
        (bool success, ) = address(wallet).call{value: 100}("");
        require(success, "Receive failed");
        vm.stopPrank();
        uint256 endBalance = address(wallet).balance;
        console.log(endBalance);
        assertEq(startBalance+amount, wallet.getBalance());
    }
    function testfailedAddAllowedWithdrawers() public
    {
       wallet.addAllowedWithdrawers(0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C);
       wallet.addAllowedWithdrawers(0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd);
       wallet.addAllowedWithdrawers(0x074AC318E0f004146dbf4D3CA59d00b96a100100);
       vm.expectRevert();
       wallet.addAllowedWithdrawers(0x57C91e4803E3bF32c42a0e8579aCaa5f3762af71);
       
    }

      function test_isnotOwner() public
    { 
       address checkAddress= vm.addr(1);
       vm.startPrank(checkAddress);
       vm.expectRevert();
       wallet.addAllowedWithdrawers(0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C);
     }

    function test_isOwner() public
    { 
       wallet.addAllowedWithdrawers(0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C);
    }
    
    function test_AddAllowedWithdrawers() public
    {  
       address newAddress= 0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C;
       wallet.addAllowedWithdrawers(newAddress);
       assertEq(wallet.allowedWithdrawers(newAddress), 0);
    }
    
    function test_changeAllowedWithdrawers() public
    {
        address _address=0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C; 
        wallet.addAllowedWithdrawers(_address);
        address newAddress=0x562b99aCA39C6e94d93F483E074BBaf5789c87Cd;
        wallet.changeAllowedWithdrawers(_address,newAddress);
        assertEq(wallet.allowedWithdrawers(newAddress), 0);
    }
   
    function test_withdraw() public
    {
       uint256 initialBalance = address(wallet).balance;
       uint256 amount = 5;
       address _address=0x710F7099fFe558091854b0A5Bd88DFc88aD5ac6C; 
       wallet.addAllowedWithdrawers(_address);
       vm.deal(_address, 3000);
       //vm.startPrank(_address);
       payable(address(wallet)).transfer(300);
       console.log(address(_address).balance);
       console.log(initialBalance);
       console.log(address(msg.sender).balance);
       console.log(address(wallet));
       console.log(address(msg.sender));
       vm.expectRevert();
       wallet.withdraw(amount);
       //console.log(address(wallet).balance);
    }

    function test_IsOwnerOrAllowed() public
    {   
        address checkAddress= vm.addr(1);
        uint256 amount=50;
        vm.deal(checkAddress, amount);
        payable(address(wallet)).transfer(300);
        vm.startPrank(checkAddress);
        vm.expectRevert();
        wallet.withdraw(amount);
        
    }
}
