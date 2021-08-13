ThisBuild / scalaVersion     := "2.12.12"
ThisBuild / version          := "0.1"
ThisBuild / organization     := "Jinhua@Visinex"

lazy val root = (project in file("."))
  .settings(
    name := "uart",
    libraryDependencies ++= Seq(
      "edu.berkeley.cs" %% "chisel3" % "3.4.2",
      "edu.berkeley.cs" %% "chiseltest" % "0.3.2"
    ),
    scalacOptions ++= Seq(
      "-Xsource:2.11",
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit"
    ),
    addCompilerPlugin("edu.berkeley.cs" % "chisel3-plugin" % "3.4.2" cross CrossVersion.full),
    addCompilerPlugin("org.scalamacros" % "paradise" % "2.1.1" cross CrossVersion.full)
  )

