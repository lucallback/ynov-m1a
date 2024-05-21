// SonarQube static code analysis.
//
// Check for code quality with static anaylsis scanning.
package main

import (
	"context"
	"os"
)

type M1A struct{}

// Returns a container that echoes whatever string argument is provided
func (m *M1A) BuildAndPush(
	ctx context.Context,
	buildSrc *Directory,
	registry string,
	imageName string,
	username string,
	passwordVar string,
) (string, error) {
	ctr := dag.Container().
		From("docker.io/node:18").
		WithMountedDirectory("/app", buildSrc).
		WithWorkdir("/app").
		WithExec([]string{"npm", "install"}).
		WithExec([]string{"npm", "run", "build"})

	prodImage := dag.Container().
		WithRegistryAuth(registry, username, dag.SetSecret("password", os.Getenv(passwordVar))).
		From("docker.io/nginx:1.25.5-alpine").
		WithDirectory("/usr/share/nginx/html", ctr.Directory("/app/dist"))

	return prodImage.Publish(ctx, imageName)
}
