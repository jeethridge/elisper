# Exclude all :ignore tagged tests from running
ExUnit.configure(exclude: [:ignore])
ExUnit.start()
