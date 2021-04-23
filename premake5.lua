
local OutputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"


workspace "Sandbox"
    configurations 
    {
        "Debug",
        "Release"
    }
    platforms
    {
        "Win64"
    }

    defines
    {
        "NOMINMAX",
        "SDL_MAIN_HANDLED",
        "IMGUI_IMPL_OPENGL_LOADER_GLAD2"
    }

    language "C++"
    cppdialect "C++17"
    systemversion "latest"
    flags { 
        "MultiProcessorCompile", -- faster compile time
    }

    warnings "Extra"
   

    filter "configurations:Debug"
        symbols "On"
        runtime "Debug"
    
    filter "configurations:Release"
        optimize "Full"
        runtime "Release"

    
    filter "platforms:Win64"
        architecture "x86_64"
        libdirs
        {
            "%{wks.solution}/external/lib/x86_64"
        }
        debugenvs 
        {
            "PATH=$(SolutionDir)/external/x86_64;%PATH%"
        }
        -- buildoptions { "/bigobj" } -- In case the code uses too many templates :) activate on a per-need basis
        

    project "Sandbox"
        kind "ConsoleApp"
        buildoptions{"/openmp /bigobj"}

        targetdir("bin/" .. OutputDir .. "/%{prj.name}")
        objdir("bin-int/" .. OutputDir .. "/%{prj.name}")
    
        includedirs
        {
            "%{prj.location}/include",
            "%{wks.location}/external/include"
        }

        files
        {
            "%{prj.location}/src/**.cpp",
            "%{prj.location}/include/**.hpp",   
            "%{prj.location}/include/**.h",

            "%{wks.location}/external/src/**.cpp",
            "%{wks.location}/external/src/**.c"
        }
        
        links 
        {
            "SDL2",
            "assimp-vc142-mt",
            "OpenAL32",
            "freetype"
        }
        


