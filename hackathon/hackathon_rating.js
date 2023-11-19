// create a function on a Hackathon contract to sort through a list of projects and find which one is the top-rated from a list of it's ratings.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hackathon {
    struct Project {
        string title;
        uint[] ratings;
    }
    
    Project[] projects;

    // TODO: add the findWinner function
    function findWinner() external view returns(Project memory) {
        // Validate that there are projects in the array
        require(projects.length > 0, "No projects available");

        Project memory winner;
        uint highestAvg = 0;

        for (uint i = 0; i < projects.length; i++) {
            uint sum = 0;
            uint avg = 0;

            // Ensure there are ratings for the project
            if (projects[i].ratings.length > 0) {
                for (uint j = 0; j < projects[i].ratings.length; j++) {
                    sum += projects[i].ratings[j];
                }
                avg = sum / projects[i].ratings.length;

                if (avg > highestAvg) {
                    highestAvg = avg;
                    winner = projects[i];
                }
            }
        }

        // Ensure that a winner with ratings was found
        require(highestAvg > 0, "No ratings found");

        return winner;
    }

    function newProject(string calldata _title) external {
        // creates a new project with a title and an empty ratings array
        projects.push(Project(_title, new uint[](0)));
    }

    function rate(uint _idx, uint _rating) external {
        // rates a project by its index
        projects[_idx].ratings.push(_rating);
    }
}
