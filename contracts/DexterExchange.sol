// SPDX-License-Identifier: GPL-3.0

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

pragma solidity >=0.6.2;

/**
 * @dev Interface used in DexterExchange is Defined in DexRouter
 */

import "./DexRouter.sol";

contract DexterExchange {
    // declare state variable of type PancakeRouter02 interface
    IPancakeRouter02 public pancakeRouter;

    // the pancakeRouter variable will hold all internal methods of any contract with its address specified in the constructor
    constructor(address _pancakeRouter) {
        pancakeRouter = IPancakeRouter02(_pancakeRouter);
    }

    /**
     * @dev Emits a Transfer event when called in a function
     */
    event SwapTransfer(
        address from,
        address to,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOut
    );

    /**
     * @dev creates address array for transacted tokens
     *
     * Approves tokens to be transacted using the IERC20 approve method
     *
     * Transacts BNB for tokens
     *
     * Emit Transfer and log details of token swap
     */
    function swapExactBNBForTokens(uint amountOutMin, address tokenOut)
        external
        payable
    {
        address[] memory path = new address[](2);
        path[0] = pancakeRouter.WETH();
        path[1] = tokenOut;
        IERC20(pancakeRouter.WETH()).approve(address(pancakeRouter), msg.value);
        pancakeRouter.swapExactETHForTokens{value: msg.value}(
            amountOutMin,
            path,
            msg.sender,
            block.timestamp + 60 * 10
        );
        uint256[] memory amounts = pancakeRouter.getAmountsOut(msg.value, path);
        emit SwapTransfer(
            address(pancakeRouter),
            msg.sender,
            pancakeRouter.WETH(),
            tokenOut,
            msg.value,
            amounts[1]
        );
    }
}
