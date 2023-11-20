//Zombie Factory (random Zombie generator)

pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    // declare our event here
    event NewZombie (uint zombieId, string name, uint dna); 

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // Structs allow you to create more complicated data types that have multiple properties.
    struct Zombie {
        string name;
        uint dna;
    }

    Zombie[] public zombies; //We're going to want to store an army of zombies in our app. And we're going to want to show off all our zombies to other apps, so we'll want it to be public.

    //creates a new Zombie, and adds it to the zombies array + fires an event
    function _createZombie(string memory _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna); //fire the NewZombie event after adding the new Zombie to our zombies array
    }

    //generates a pseudo-random DNA that is 16 digits long
    function _generateRandomDna(string memory _str) private view returns (uint) { //view function, meaning it's only viewing the data but not modifying it. Pure functions, which means you're not even accessing any data in the app (a*b)
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    //public function that ties everything together
    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

