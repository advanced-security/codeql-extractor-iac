import os
from ghastoolkit import CodeQLPacks, CodeQLPack, GitHub
from ghastoolkit.utils.cli import CommandLine

class IaCCommandLine(CommandLine):
    def arguments(self):
        self.addModes(["publish", "version", "queries"])

        parser = self.parser.add_argument_group("packs")
        parser.add_argument("--cwd", default=os.getcwd(), help="The current working directory")
        parser.add_argument("--bump", default="patch", choices=["major", "minor", "patch"], help="The version bump to apply to the pack (major, minor, patch)")

    def run(self):
        arguments = self.parse_args()
        print("===== Running IaC CodeQL Pack CLI =====")
        
        pack_lib = CodeQLPack(os.path.join(arguments.cwd, "ql", "lib", "qlpack.yml"))
        pack_src = CodeQLPack(os.path.join(arguments.cwd, "ql", "src", "qlpack.yml"))

        packs = CodeQLPacks()
        packs.append(pack_lib)
        packs.append(pack_src)


        if arguments.mode == "publish":
            self.runPublish(arguments, packs)
        elif arguments.mode == "queries":
            print("CodeQL Queries:")
            for query in pack_src.resolveQueries():
                print(f"{query}")
        elif arguments.mode == "version":
            self.runBump(arguments, packs)

    def runPublish(self, args, packs):
        for pack in packs:
            print(f"CodeQL Pack :: {pack} ({pack.path})")

            if pack.remote_version != pack.version:
                print(f"Publishing {pack} ({pack.remote_version} -> {pack.version})")
                pack.publish()
            else:
                print(f"Skipping publish as remote pack is up to date ({pack.remote_version})")

    def runBump(self, args, packs):
        for pack in packs:
            old_version = pack.version
            print(f"CodeQL Pack :: {pack} ({pack.path})")
            pack.updateVersion(args.bump)
            print(f"Bumping {pack} ({old_version} -> {pack.version})")
            pack.updatePack()

cli = IaCCommandLine()
cli.run()
