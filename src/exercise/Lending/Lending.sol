contract Lending {  
    
    struct borrower {
        uint256 amountborrow;
        uint256 amountcollateral;
    }
    uint public poolValue;
    uint public collateralValue;
    uint public borrowlValue;
    uint public ratio = 0.66;
    uint ETHvalue = 1000;
    uint wad=10**18;
    uint public borrowingFee =0.01;
    address public owner;
    IERC20 public dai;
    IERC20 public bond;
    IERC20 public eth;
    mapping(address => uint256) public depositors;
    mapping(address => borrower) public borrowers;
    constructor(address _dai, address _bond,address _eth) {
        owner = msg.sender;
        dai = IERC20(_dai);
        bond = IERC20(_bond);
        eth = IERC20(_eth);
    }
        modifier IsOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }
        modifier IsPosetive(uint amount) {
        require(amount>0,"amount not bigger then 0");
        _;
    }

function depositors(uint amount) IsPosetive(amount) {
  dai.transferFrom(msg.sender,address(this), amount);
  depositors[msg.sender]+=amount;
  poolValue+= amount;
  bond.mint(msg.sender, amount);
}
 function unbond (uint amount) IsPosetive(amount){
  require(amount<=depositors[msg.sender],"amount not bigger then 0");
  bond.burn(msg.sender,amount)
  dai.transfer(msg.sender, amount);
  depositors[msg.sender]-=amount;
  poolValue-= amount;
 }

function addCollateral (uint amount) IsPosetive(amount){
  eth.transferFrom(msg.sender,address(this), amount);
  collateralValue+=amount;
  borrowers[msg.sender].amountcollateral+=amount;
}
 
 function removeCollateral (uint amount) IsPosetive(amount){
  borrowers[msg.sender].amountcollateral-=amount; 
  uint needCollateral=DaiforETH(msg.sender);
  require( needCollateral>[msg.sender].amountborrow=, "not enogth collateral");
  eth.transfer(msg.sender, amount);
  collateralValue-=amount;
} 

function borrow(uint amount) IsPosetive(amount){
uint dai=DaiforETH(msg.sender);
require(dai>amount+borrowers[msg.sender].amountborrow, "not enogth collateral");
require(poolValue>amount, "not enogth money in the pool");
require([msg.sender].amountborrow==0, "you have a borrow");
dai.transfer(msg.sender, amount);
borrowers[msg.sender].amountborrow+=amount;
borrowlValue+=amount;
poolValue-= amount;
}
 
function repay(uint amount) IsPosetive(amount){
uint amountborrow= borrowers[msg.sender].amountborrow;
require(amountborrow*borrowingFee+amountborrow>amount, "amount bigger then what borrowerd");
dai.transferFrom(msg.sender,address(this), amount);
borrowers[msg.sender].amountborrow-=amountborrow;
borrowlValue-=amountborrow;
poolValue+= amountborrow;
}

function DaiforETH(address borrow) public view returns (uint) {
       
       return ETHvalue * ratio * borrowers[borrow].amountCollateral;
 }







    }