# **Autonomous Mower Project Documentation - Other informations**

## **📝 Rules**
This document outlines the procedures and best practices used to maintain the project.  
It includes guidelines for branching strategies, implementing new features and bug fixes, managing new versions and documentation tracking.  
By following these rules, it is ensured consistent, organized, and efficient development, making it easier to track changes.

### **🔀 Branching strategy**
To effectively separate stable and ongoing work, the following branching strategy is employed:  
- The `main` branch holds the **latest stable version** of the project.  
- The `develop` branch is used for **ongoing development**, containing the most recent unstable code.  

### **🐛 New features and bug fixes**
Whenever a new feature is added or a bug needs fixing, follow this process:  
1. Create an **issue** to track the new feature or bug fix.  
2. Create a new branch using the following naming conventions:  
   - For new features: `feature/name_of_feature`  
   - For bug fixes: `bugfix/name_of_bug`  
3. Once the feature or bug fix is complete, commit your changes with a message formatted as:  
   - `"Implemented name_of_feature. Closes #issue_number"`  
   - `"Fixed name_of_bug. Closes #issue_number"`  
4. Push the changes to the respective branch and submit a **pull request** to merge the changes into the `develop` branch.  

### **📦 New versions**
When the `develop` branch reaches a stable version:  
1. Commit and merge the changes from `develop` into the `main` branch.  
2. Tag the `main` branch with the new version number. 

### **📜 Documentation tracking**
To maintain an organized and comprehensive history of the project from its inception, the following process is followed:  
1. A `/doc` folder has been created to store all project-related documentation.  
2. A detailed documentaton outlining the current version is stored in the folder.
3. Whenever a change occurs (such as the addition of a new feature, a bug fix, or any other modification), the documentation is updated alongside the code.  
4. After each release of a new version, the file corresponding to that release becomes the new base for documentation, and the cycle repeats from step 3.   
