/**           |
*           \ | /
*         -=- 0 -=-    ryanhendricks@gmail.com
*           / | \                          _\/_
*             |                            //☯\  _\/_
*   _  ___ ___  _ __ __ _  _ _  _ _ __  __ _ | __/☯\\ _
* .-"-._.-"-._.-.-"-._.-"-._.-.-"-._.-"-._,-'|"'""-|-,_
* -"-._.-"-._.-"-._.-.-"-._.-"-._.-.-"-~/          |
* _.-"-._.-"-._.-"-._.-.-"-._.-"-._.-""/           jgs */
/// @title Curriculum Vitae
/// @author Ryan Hendricks
pragma solidity ^0.4.16;


library Structures {

    struct Basics {
        string _name;           /// Name; First & Last
        string _title;          /// Job Title 
        string _summary;        /// Executive Summary
        string _website;        /// Website URL
        string _phone;          /// Phone Number
        string _email;          /// Email Address
        string _description;    /// Description
    }

    struct Position {
        string _company;        /// Name of Company
        string _position;       /// Position at Company
        string _startDate;      /// Start Date
        string _endDate;        /// End Date (blank if present)
        string _summary;        /// Summary of position
        string _highlights;     /// Notable Accomplishments
    }

    struct Education {
        string _institution;    /// Name of School
        string _focusArea;      /// Major and/or Minor
        int32 _yearStart;       /// Year started degree
        int32 _yearFinish;      /// Graduation year
    }

    struct Project {
        string name;            /// Name of project
        string link;            /// Link to project website
        string description;     /// Description of project
    }

    struct Publication {
        string title;           /// Title of Publication
        string link;            /// URL of publication
        string description;     /// Summary or Abstract
    }

    struct Skill {
        string name;            /// Skill name
        int32 level;            /// Skill level 1-10
    }
}


contract SolidityCV {
    mapping (string => string) basics;
    
    /// @notice address of contract owner
    address public owner;

    /// @dev Mapping data into data structures 
    Structures.Position[] public positions;
    Structures.Project[] public projects;
    Structures.Education[] public education;
    Structures.Skill[] public skills;
    Structures.Publication[] public publications;

    /// @dev set the creator of contract as owner
    function solidityCV() {
        owner = msg.sender;
    }

    /// @dev allow only the contract owner to edit
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    /// Functions for modifying CV data

    /**
    * @dev basic data is set and edited using a text-based key
    * @dev the key for each item in BasicData is the name of the item
    * @dev i.e. to set/edit name the key is "name".
    * @dev sets basic data attributes of CV contract
    * @param _key string is the data point to add
    * @param _value string is the data to set as the basic data point
    */
    function editBasicData (string key, string value) public onlyOwner() {
        basics[key] = value;
    }

    /**
    * @dev query basic data from CV contract
    * @param arg is a string that is the basic data point specifier
    * @return the data stored under basic info and the data point specifier
    */
    function getBasicData (string arg) public constant returns (string) {
        return basics[arg];
    }


    /**
     * @dev edit projects
     * @param operation bool used to indicate if data is being added or deleted
     * @param name is the name of the project
     * @param link is the URL of the project
     * @param description is a free response decription of the project
     */
    function editProject (
        bool operation,
        string name,
        string link,
        string description
    ) public onlyOwner()
    {
        if (operation) {
            projects.push(Structures.Project(name, link, description));
        } else {
            delete projects[projects.length - 1];
        }
    }

    function editEducation (
        bool operation,
        string _institution,
        string _focusArea,
        int32 _yearStart,
        int32 _yearFinish
    ) public onlyOwner()
    {
        if (operation) {
            education.push(
                Structures.Education(
                    _institution,
                    _focusArea,
                    _yearStart,
                    _yearFinish
                    )
            );
        } else {
            delete education[education.length - 1];
        }
    }

    function editSkill(bool operation, string name, int32 level) public onlyOwner() {
        if (operation) {
            skills.push(Structures.Skill(name, level));
        } else {
            delete skills[skills.length - 1];
        }
    }

    function editPublication (bool operation, string name, string link, string language) public onlyOwner() {
        if (operation) {
            publications.push(Structures.Publication(name, link, language));
        } else {
            delete publications[publications.length - 1];
        }
    }


    function getSize(string arg) public constant returns (uint) {
        if (keccak256(arg) == keccak256("projects")) {return projects.length;}
        if (keccak256(arg) == keccak256("education")) {return education.length;}
        if (keccak256(arg) == keccak256("publications")) {return publications.length;}
        if (keccak256(arg) == keccak256("skills")) {return skills.length;}
        revert();
    }
}