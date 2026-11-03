// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import "forge-std/Test.sol";
import {FounderMedal} from "../src/FounderMedal.sol";
import {FounderArt} from "../src/FounderArt.sol";

contract FounderMedalTest is Test {
    address constant ANDY = 0xa959D8EedeD6fB440cA584D1e87E581168bBF628;
    FounderMedal m;
    function setUp() public { m = new FounderMedal(ANDY, address(0xBEEF)); }

    function test_MintedToRecipientNotDeployer() public view {
        assertEq(m.ownerOf(1), ANDY); assertEq(m.balanceOf(ANDY), 1); assertEq(m.balanceOf(address(this)), 0);
        assertEq(m.totalSupply(), 1); assertEq(m.MAX_SUPPLY(), 1);
        assertEq(m.name(), "Youcognito Founder's Medal"); assertEq(m.symbol(), "YCFOUNDER");
    }
    function test_NoOtherTokens() public {
        vm.expectRevert(); m.ownerOf(0); vm.expectRevert(); m.ownerOf(2); vm.expectRevert(); m.tokenURI(2);
    }
    function test_NoMintSelectors() public {
        bytes4[4] memory sels = [bytes4(keccak256("mint(address)")), bytes4(keccak256("mint()")), bytes4(keccak256("safeMint(address,uint256)")), bytes4(keccak256("mint(address,uint256)"))];
        for (uint i; i < 4; i++) { (bool ok,) = address(m).call(abi.encodeWithSelector(sels[i], address(this), 2)); assertFalse(ok); }
    }
    function test_Royalty() public view {
        (address r, uint256 a) = m.royaltyInfo(1, 10000); assertEq(r, address(0xBEEF)); assertEq(a, 500);
        assertTrue(m.supportsInterface(0x2a55205a)); assertTrue(m.supportsInterface(0x80ac58cd));
    }
    function test_NoRoyaltyWhenZero() public {
        FounderMedal n = new FounderMedal(ANDY, address(0)); (address r, uint256 a) = n.royaltyInfo(1, 10000);
        assertEq(r, address(0)); assertEq(a, 0);
    }
    function test_TransferWorks() public {
        vm.prank(ANDY); m.transferFrom(ANDY, address(0xCAFE), 1); assertEq(m.ownerOf(1), address(0xCAFE));
    }
    function test_MintToContractWithoutReceiverOk() public {
        FounderMedal n = new FounderMedal(address(this), address(0)); assertEq(n.ownerOf(1), address(this));
    }
    function test_TokenURI() public {
        string memory u = m.tokenURI(1);
        assertEq(bytes(u).length > 1000, true);
        vm.writeFile("out-uri.txt", u);
    }
}

contract FounderForkTest is Test {
    function test_ForkDeployToAndy() public {
        string memory url = vm.envOr("FORK_URL", string(""));
        if (bytes(url).length == 0) return;
        vm.createSelectFork(url);
        address andy = 0xa959D8EedeD6fB440cA584D1e87E581168bBF628;
        FounderMedal m = new FounderMedal(andy, andy);
        assertEq(m.ownerOf(1), andy);
        (address r, uint256 a) = m.royaltyInfo(1, 10000); assertEq(r, andy); assertEq(a, 500);
        vm.writeFile("./out-svg/uri.txt", m.tokenURI(1));
        emit log_named_uint("andy code size", andy.code.length);
    }
}
